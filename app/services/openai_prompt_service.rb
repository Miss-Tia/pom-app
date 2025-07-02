require "http"
require "json"

class OpenaiPromptService
  def self.generate_prompt
    response = HTTP.auth("Bearer #{ENV['OPENAI_API_KEY']}")
                   .post("https://api.openai.com/v1/chat/completions",
                     json: {
                       model: "gpt-4o", # Or "gpt-3.5-turbo" if needed
                       messages: [
                         { role: "system", content: "You are a mindfulness coach helping users reflect on their inner world." },
                         { role: "user", content: "Give me a short but powerful journal prompt to help me reflect today." }
                       ],
                       temperature: 0.7
                     })

    body = JSON.parse(response.body.to_s)
    body["choices"][0]["message"]["content"]
  rescue => e
    Rails.logger.error("OpenAI Error: #{e.message}")
    "🧘‍♀️ Describe one thing that brought you peace today."
  end
end
