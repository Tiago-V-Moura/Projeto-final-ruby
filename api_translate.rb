require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class Api_translate
	def traduzir(msg, source, target)
		# puts "Recebendo os paramentros para tradução\n#{msg}\n#{target}\n#{source}"
		url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Post.new(url)
		request["content-type"] = 'application/x-www-form-urlencoded'
		request["Accept-Encoding"] = 'application/gzip'
		request["X-RapidAPI-Key"] = ''
		request["X-RapidAPI-Host"] = 'google-translate1.p.rapidapi.com'
		request.body = "q=#{msg}&target=#{target}&source=#{source}"

		response = http.request(request)
		json = JSON.parse(response.read_body)
		return json['data']['translations'][0]['translatedText']
	end


	def detectar(msg)

		url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2/detect")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Post.new(url)
		request["content-type"] = 'application/x-www-form-urlencoded'
		request["Accept-Encoding"] = 'application/gzip'
		request["X-RapidAPI-Key"] = '68d8276a5amsh6a3c3757b57e0d3p18a784jsnb9456f1bf60f'
		request["X-RapidAPI-Host"] = 'google-translate1.p.rapidapi.com'
		request.body = "q=#{msg.to_s}"

		response = http.request(request)
		json = JSON.parse(response.read_body)

		return json['data']['detections'][0][0]["language"]
	end

	def lista_linguas
		require 'uri'
		require 'net/http'
		require 'openssl'

		url = URI("https://google-translate1.p.rapidapi.com/language/translate/v2/languages")

		http = Net::HTTP.new(url.host, url.port)
		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(url)
		request["Accept-Encoding"] = 'application/gzip'
		request["X-RapidAPI-Key"] = '68d8276a5amsh6a3c3757b57e0d3p18a784jsnb9456f1bf60f'
		request["X-RapidAPI-Host"] = 'google-translate1.p.rapidapi.com'

		response = http.request(request)
		json = JSON.parse(response.read_body)
		json =  json['data']['languages'].to_a

		json.each do |line|
			return line['language']
		end
	end

end
