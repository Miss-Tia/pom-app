// Peace of Mind (POM) App: Updated JS file for reliability

import "@hotwired/turbo-rails";
import "controllers";
import Rails from "@rails/ujs";
Rails.start();

function bindGardenNotesToggle() {
  const gardenLinks = document.querySelectorAll(".read-toggle");
  console.log("🌿 Garden links found:", gardenLinks.length);

  gardenLinks.forEach(link => {
    if (!link.dataset.bound) {
      link.dataset.bound = "true";
      link.addEventListener("click", event => {
        event.preventDefault();

        const gardenId = link.dataset.garden_id;
        const preview = document.getElementById(`notes-preview-${gardenId}`);
        const full = document.getElementById(`notes-full-${gardenId}`);

        if (preview && full) {
          preview.classList.add("hidden");
          full.classList.remove("hidden");
          link.remove();
        }
      });
    }
  });
}

function bindMonthToggles() {
  document.querySelectorAll(".month-section").forEach(section => {
    const toggle = section.querySelector(".month-toggle");
    const entries = section.querySelector(".month-entries");

    if (toggle && entries && !toggle.dataset.bound) {
      toggle.dataset.bound = "true";
      toggle.addEventListener("click", () => {
        document.querySelectorAll(".month-entries").forEach(el => el.classList.add("hidden"));
        document.querySelectorAll(".month-toggle").forEach(btn => btn.classList.remove("open"));

        entries.classList.remove("hidden");
        toggle.classList.add("open");
      });
    }
  });
}

function bindProgressNotes() {
  const dataTag = document.getElementById("progress-notes-data");
  const list = document.getElementById("progress-notes-list");
  const loadMoreBtn = document.getElementById("load-more-notes");

  if (!dataTag || !list) return;

  const notes = JSON.parse(dataTag.textContent);
  window.progressNotes = [...notes];
  let visibleCount = list.children.length;

  const renderNote = (note, index) => {
    const li = document.createElement("li");
    li.className = "note-item";
    li.dataset.noteIndex = index;

    const timestamp = new Date(note.timestamp);
    const formatted = timestamp.toLocaleString("en-US", {
      timeZone: "America/New_York",
      year: "numeric",
      month: "long",
      day: "numeric",
      hour: "numeric",
      minute: "2-digit",
      hour12: true
    });

    const fullContent = note.content;
    const isLong = fullContent.length > 100;
    const preview = isLong ? fullContent.slice(0, 100) + "..." : fullContent;

    li.innerHTML = `
      <p class="note-timestamp"><strong>${formatted}</strong></p>
      <p class="note-content">
        <span class="note-text">${preview}</span>
        ${isLong ? `<span class="read-more" style="color:#b75e35; cursor:pointer;"> Read more</span>` : ""}
      </p>
    `;

    list.appendChild(li);
  };

  if (loadMoreBtn) {
    loadMoreBtn.addEventListener("click", () => {
      const nextBatch = window.progressNotes.slice(visibleCount, visibleCount + 5);
      nextBatch.forEach((note, idx) => renderNote(note, visibleCount + idx));
      visibleCount += nextBatch.length;
      if (visibleCount >= window.progressNotes.length) loadMoreBtn.remove();
    });
  }

  list.addEventListener("click", (e) => {
    if (e.target.classList.contains("read-more")) {
      const noteText = e.target.previousElementSibling;
      const index = e.target.closest(".note-item").dataset.noteIndex;
      noteText.textContent = window.progressNotes[index].content;
      e.target.remove();
    }
  });
}

function clearNoteFormOnSubmit() {
  document.addEventListener("turbo:submit-end", (event) => {
    const form = event.target;
    if (form.id === "note-form" && event.detail.success) {
      form.reset();
    }
  });
}

// Run all bindings on load and render
const initAll = () => {
  bindProgressNotes();
  bindGardenNotesToggle();
  bindMonthToggles();
  clearNoteFormOnSubmit();
};

document.addEventListener("turbo:load", initAll);
document.addEventListener("turbo:render", initAll);
