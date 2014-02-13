
require 'yaml'
require 'mail'

# Assumes configuration is present on the filesystem at path:
#  - /auto-deploy-conf.yml

conf_path = '/auto-deploy-conf.yml'
Conf = YAML.load_file(conf_path)

class AutoDeployController < Kenji::Controller
  post '/:secret/deploy' do |secret|
    unless secret == Conf['secret']
      puts 'Bad authentication.'
      kenji.respond(403, 'Bad authentication.')
    end


    log = 'Deploy request authorized... processing.'
    log << "\n\n---\n\n"

    script = Conf['script']

    # restart app...

    # TODO: handle failures
    log << `#{script}`
    log << "\n\n."

    mail = Mail.new do
      subject 'Quoth deploy...'
      to Conf['mailto']
      from 'deploys@quothapp.com'
      body log
    end

    begin
      smtp = Hash[Conf['smtp'].map {|k,v| [k.to_sym, v]}]
      mail.delivery_method :smtp,  smtp
      mail.deliver
    rescue
      puts 'Error mailing log :\'('
      puts log
    end

    {
      status: 200,
      message: 'Deploy successful.'
    }
  end
end
