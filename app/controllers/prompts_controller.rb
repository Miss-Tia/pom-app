require "openai"

class PromptsController < ApplicationController
  skip_forgery_protection

  def generate
    openai = OpenAI::Client.new
    # binding.pry

    response = openai.chat.completions.create(
        model: "gpt-4",
        messages: [
          { role: "system", content: "You are a mindful journaling assistant who writes thoughtful and calming reflection and self-care prompts." },
          { role: "user", content: "Give me a new, calming journal prompt related to self-reflection or nature." }
        ],
    )
    # binding.pry
    content = response.choices[0]&.message&.content


    if content.present?
      render json: { prompt: content }
    else
      render json: { error: "No prompt received" }, status: :bad_request
    end
  end
end
