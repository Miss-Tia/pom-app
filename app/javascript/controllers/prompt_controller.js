import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="prompt"
export default class extends Controller {
  static targets = ["output", "spinner", "generateButton"]

  generate(event) {
    event.preventDefault();

    // Show spinner, disable button, update text
    if (this.hasSpinnerTarget) this.spinnerTarget.style.display = "inline-block";
    if (this.hasGenerateButtonTarget) {
      this.generateButtonTarget.disabled = true;
      this.generateButtonTarget.textContent = "Generating...";
    }

    fetch("/generate_prompt", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": this.getMetaValue("csrf-token")
      }
    })
      .then(response => {
        if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
        return response.json();
      })
      .then(data => {
  const promptDisplay = this.outputTarget;
  const hiddenPromptInput = document.getElementById("journal_entry_prompt");
  const categorySelect = document.querySelector("#journal_entry_category_id");

  this.promptGenerated = false; // Default

  if (data.prompt) {
    this.promptGenerated = true;

    promptDisplay.textContent = data.prompt;
    promptDisplay.style.display = "block";

    if (hiddenPromptInput) {
      hiddenPromptInput.value = data.prompt;
    }

    if (this.hasGenerateButtonTarget) {
      this.generateButtonTarget.disabled = true;
      this.generateButtonTarget.classList.add("btn-disabled");
      this.generateButtonTarget.textContent = "Prompt Generated ✨";
    }

    if (categorySelect) {
      const generatedOption = [...categorySelect.options].find(opt => opt.text === "Generated Prompt");
      if (generatedOption) {
        categorySelect.value = generatedOption.value;
        categorySelect.classList.add("locked");
        categorySelect.setAttribute("data-locked", "true");
      }
    }
  } else {
    promptDisplay.textContent = "Sorry, no prompt could be generated.";
    promptDisplay.style.display = "block";
  }
})
      .finally(() => {
  if (this.hasSpinnerTarget) this.spinnerTarget.style.display = "none";

  if (this.hasGenerateButtonTarget && !this.promptGenerated) {
    this.generateButtonTarget.disabled = false;
    this.generateButtonTarget.textContent = "✨ Generate Prompt";
  }
});

  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`);
    return element && element.getAttribute("content");
  }
}
