class InteractionController < ApplicationController
  def new

    # richiedo il token di autorizzazione solo se necessario
    # Se il parametro della sessione non è stato inizializzato
    # O se è passata un ora da quando è stato inizializzato
    if @first_visit or Time.now >= session[:expire]
      # Processo di autenticazione
      response = RestClient.post 'https://icdaccessmanagement.who.int/connect/token',
                                  {
                                      scope: 'icdapi_access',
                                      grant_type: 'client_credentials',
                                      client_id: 'client id',
                                      client_secret: 'client secret'
                                  }
      # Il token scade dopo un ora
      session[:expire] = Time.now + 1.hour

      # Parsing della risposta
      @response = JSON.parse(response)
      session[:token] = @response["access_token"]

    end
  end

  def create
  end

  def show
    # costruisco l'uri con il parametro desiderato
    # Se il parametro di ricerca non è stato passato ritorno alla pagina precedente
    if params[:ricerca] == ""
      redirect_to interaction_new_path, notice: 'Inserire un parametro di ricerca!'
    else
      uri = "http://id.who.int/icd/entity/search?q={#{params[:ricerca]}}"

      response = RestClient.get uri, {'Authorization': "Bearer #{session[:token]}",
                                      'Accept': :json,
                                      'Accept-Language': 'en'
      }
      @response = JSON.parse(response)
    end
  end

end
