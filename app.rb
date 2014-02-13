

conf_path = '/auto-deploy-conf.yml'
Conf = YAML.load_file(conf_path)

class AutoDeployController < Kenji::Controller
  post '/:secret/deploy' do |secret|
    kenji.respond(403, 'Bad authentication.') unless secret == Conf['secret']

    # TODO: implement me
  end
end
