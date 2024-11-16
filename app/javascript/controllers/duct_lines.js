document.addEventListener('turbo:load', function() {
  function handleFileUpload(input, textElement) {
    input.addEventListener('change', function() {
      if (this.files && this.files[0]) {
        textElement.textContent = this.files[0].name;
      } else {
        textElement.textContent = 'Click to Upload';
      }
    });
  }

  const imageUpload = document.querySelector('[data-target="image-upload"]');
  const imageUploadText = document.querySelector('[data-target="image-upload-text"]');
  const pdfUpload = document.querySelector('[data-target="pdf-upload"]');
  const pdfUploadText = document.querySelector('[data-target="pdf-upload-text"]');

  if (imageUpload && imageUploadText) {
    handleFileUpload(imageUpload, imageUploadText);
  }

  if (pdfUpload && pdfUploadText) {
    handleFileUpload(pdfUpload, pdfUploadText);
  }
});