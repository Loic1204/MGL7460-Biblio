# -*- coding: utf-8 -*-
require 'net/smtp'
require 'net/smtp'
Net.instance_eval {remove_const :SMTPSession} if defined?(Net::SMTPSession)

require 'net/pop'
Net::POP.instance_eval {remove_const :Revision} if defined?(Net::POP::Revision)
Net.instance_eval {remove_const :POP} if defined?(Net::POP)
Net.instance_eval {remove_const :POPSession} if defined?(Net::POPSession)
Net.instance_eval {remove_const :POP3Session} if defined?(Net::POP3Session)
Net.instance_eval {remove_const :APOPSession} if defined?(Net::APOPSession)

require 'tlsmail'

#
# Service pour l'envoi de courriels.
#
module ServiceCourrielGmail

  ErreurEnvoiDeCourriel       = Class.new( StandardError )

  private

  def self.var_gmail( var )
    val = ENV[var]
    return val if val && val != ""

    fail ErreurEnvoiDeCourriel, "Variable d'environnement #{var} pas definie.
                                   Requis pour l'envoi de courriels."
  end


  public

  # Effectue l'envoi d'un courriel au destinataire, en utilisant le
  # compte gmail de l'usager courant sur la machine.  Son code
  # usager doit être défini dans la variable d'environnement
  # USAGER_GMAIL et son mot de passe doit être défini dans la
  # variable MOT_DE_PASSE_GMAIL.
  #
  # Pour les tests, il faut définir PAS_DE_COURRIELS et les envois
  # ne seront pas effectués.
  #
  def self.envoyer_courriel( destinataire, sujet, contenu )
    # Source: http://thinkingeek.com/2012/07/29/sending-emails-google-mail-ruby/
    Debug.log( "ServiceCourrielGmail.envoyer_courriel( #{destinataire}, #{sujet}, #{contenu} )")

    moi = var_gmail("USAGER_GMAIL")
    Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
    Net::SMTP.start( 'smtp.gmail.com', 587, 'gmail.com', moi, var_gmail("MOT_DE_PASSE_GMAIL"), :plain ) do |smtp|
      Debug.log( "ServiceCourrielGmail.envoyer_courriel:: On effectue l'envoi a #{destinataire}")


      # Pour eviter les envois repetitifs lorsque les tests sont corrects.
      return if ENV['PAS_DE_COURRIEL'] ||  ENV['PAS_DE_COURRIELS']

      smtp.send_message( "From: #{moi}\n" <<
                         "To: #{destinataire}\n" <<
                         "Subject: #{sujet}\n" <<
                         contenu,
                         moi,
                         destinataire )
    end
  end

end

