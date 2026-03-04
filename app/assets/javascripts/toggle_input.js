// app/assets/javascripts/toggle_input.js

function toggleFeaturedImage() {
  var container = document.getElementById('featured-image-container');
  if (!container) return;

  var currentInput = container.querySelector('input');
  if (!currentInput) return;

  var currentType = currentInput.type;
  var newType = (currentType === 'file') ? 'text' : 'file';
  var name = currentInput.name;
  var id = currentInput.id;

  // Create the new input element
  var newInput = document.createElement('input');
  newInput.type = newType;
  newInput.name = name;
  if (id) newInput.id = id;

  // Replace the old input with the new one
  container.replaceChild(newInput, currentInput);

  // Optionally update the button text
  var button = document.querySelector('button[onclick="toggleFeaturedImage()"]');
  if (button) {
    button.textContent = (newType === 'file') ? 'Switch to text input' : 'Switch to file input';
  }
}