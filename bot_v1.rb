require 'telegram/bot'

# Fungsi untuk menentukan respons berdasarkan pesan yang diterima
def respond_to_message(message)
  case message.downcase
  when 'halo', 'Halo', 'hi', 'Hi', 'hai', 'Hai'
    return 'Halo! Ada yang bisa saya bantu tolol?'
  when 'apa kabar?', 'apa kabar'
    return 'Saya hanyalah bot, tapi saya baik-baik saja. anda pasti sadboy ya wkkkwk'
  when 'siapa nama kamu?', 'siapa kamu?'
    return 'Saya adalah bot sederhana yang diciptakan untuk membantu Anda.'
  when 'oi', 'p', 'tes'
    return 'ada apa kamu harus mengetik dengan baik jangan berlagak dasar tolol'
  else
    return 'Maaf, saya tidak mengerti apa yang Anda maksud.'
  end
end

token = ''

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    case message
    when Telegram::Bot::Types::Message
      # Merekam dan menampilkan pesan dari pengguna di terminal
      puts "Pesan dari pengguna: #{message.text}"

      # Mengirim pesan balasan hanya jika pesan tidak kosong
      unless message.text.nil? || message.text.empty?
        if message.text.start_with?('/') # Memeriksa apakah pesan adalah perintah
          case message.text
          when '/start'
            bot.api.send_message(chat_id: message.chat.id, text: 'Halo! Selamat Datang di Bot Baru Menetas. Silakan gunakan perintah /help untuk melihat daftar perintah.')
          when '/intro'
            bot.api.send_message(chat_id: message.chat.id, text: 'Halo! Saya adalah bot. Saya dapat membantu Anda dengan berbagai informasi. Silakan ajukan pertanyaan atau gunakan perintah kepada saya.')
          when '/help'
            bot.api.send_message(chat_id: message.chat.id, text: "Daftar perintah yang tersedia:\n/start - Memulai bot\n/intro - Memperkenalkan bot\n/help - Menampilkan daftar perintah\n/subscribe - Berlangganan pembaruan\n/about - Informasi tentang bot\n/18Ples - Informasi dewasa \n/hentai Informasi hentai")
          when '/subscribe'
            bot.api.send_message(chat_id: message.chat.id, text: "Anda telah berhasil berlangganan untuk menerima pembaruan.")
          when '/about'
            bot.api.send_message(chat_id: message.chat.id, text: "Bot ini adalah bot yang dikembangkan oleh [NAMA ANDA]. Bot ini dibuat dengan menggunakan bahasa pemograman Ruby dan library Telegram Bot API. Bot ini memiliki fitur-fitur yang dapat membantu Anda seperti permainan tebak-tebakan, informasi umum, dan lainnya.")
          when '/18Ples'
            website_url = 'https://www.xnxx.com/'
            keyboard = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [[Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Kunjungi website dewasa', url: website_url)]])
            bot.api.send_message(chat_id: message.chat.id, text: 'Klik tombol di bawah ini untuk masuk ke website dewasa:', reply_markup: keyboard)
          when '/hentai'
            website_url = 'https://nekopoi.care/'
            keyboard = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: [[Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Kunjungi website hentai', url: website_url)]])
            bot.api.send_message(chat_id: message.chat.id, text: 'Klik tombol di bawah ini untuk masuk ke website hentai:', reply_markup: keyboard)
          else
            # Menangani pesan selain perintah yang dikenali
            bot.api.send_message(chat_id: message.chat.id, text: message.text)
          end
        else
          # Jika bukan perintah, tanggapi pesan dengan fungsi respond_to_message
          response = respond_to_message(message.text)
          bot.api.send_message(chat_id: message.chat.id, text: response)
        end
      end
    else
      # Merekam dan menampilkan pesan dari pengguna di luar bot di terminal
      puts "Pesan dari pengguna di luar bot: #{message.text}"
    end
  end
end
