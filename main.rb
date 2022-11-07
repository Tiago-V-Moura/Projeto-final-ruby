require_relative 'api_translate'
require_relative 'arquivo'

class Main
	marcador =  "--"*10

	puts marcador+' PROJETO FINAL # TRADUDOR ' + marcador

	puts "Selecione para qual idioma voce quer traduzir a mensagem"

	puts "1 - Ingles \n2 - Espanhol\n3 - Portugues\n4 - Italiano"
	@idioma = gets.chomp.to_i


	case @idioma
	when 1
		@idioma_selecionado = 'en'
		idioma_nome = 'Ingles'
	when 2
		@idioma_selecionado = 'es'
		idioma_nome = 'Espanhol'
	when 3
		@idioma_selecionado = 'pt'
		idioma_nome = 'Portugues'
	when 4
		@idioma_selecionado = 'it'
		idioma_nome = 'Italiano'
	else
		puts 'Opção não disponivel'
	end



	puts marcador*2
	puts "Idioma selecinado #{idioma_nome}"
	puts marcador*2


	puts "Escreva a Frase que voce quer traduzir para o idioma: #{idioma_nome}"
	msg_original = gets.chomp.to_s
	puts marcador*2

	puts 'Detectando o idioma da frase'
	t = Api_translate.new
	puts idioma_atual = t.detectar(msg_original)
	puts marcador*2

	puts "Traduzir a mensagem"
	msg_traduzida = t.traduzir(msg_original, idioma_atual, @idioma_selecionado)
	# Chamar o tradutor e gravar o log
	puts marcador *2
	puts "Mensagem traduzida: #{msg_traduzida}"

	arquivo = Salvar_Arquivo.new
	log = arquivo.gravar(msg_original, msg_traduzida)
	puts marcador *2
	arquivo.imprimir(log)




end