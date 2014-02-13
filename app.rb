

conf_path = '/auto-deploy-conf.yml'
Conf = YAML.load_file(conf_path)

class AutoDeployController < Kenji::Controller
  post '/:secret/deploy' do |secret|
    unless secret == Conf['secret']
      puts 'deploy request unauthorized'
      kenji.respond(403, 'Bad authentication.')
    end
    puts 'deploy request unauthorized... processing'


    # TODO: implement me
  end
end
