const fs = require('fs');

// Specify the array of source file paths and the destination file path
const sourceFilePaths = [
  'utils/welcome.sh',
  'helpers/helpers.sh',
  'utils/checkOS.sh',
  'utils/checkXcodeCli.sh',
  'utils/DS_Store.sh',
  'utils/checkFiles.sh',
  'configs/ssh.sh',
];
const destinationFilePath = 'install.sh';

// Function to clear the destination file
function clearDestination(callback) {
  fs.writeFile(destinationFilePath, '', (err) => {
    callback(err);
  });
}

// Function to append content from a source file to the destination file
function appendToFile(sourcePath, destinationPath, callback) {
  fs.readFile(sourcePath, 'utf8', (readErr, data) => {
    if (readErr) {
      callback(readErr);
    } else {
      // Split the data into lines and filter out lines starting with "#"
      const lines = data
        .split('\n')
        .filter((line) => !line.trim().startsWith('# '));

      // Join the remaining lines and append to the destination file
      const filteredData = lines.join('\n');

      fs.appendFile(destinationPath, filteredData, (appendErr) => {
        callback(appendErr);
      });
    }
  });
}

// Process files: clear destination, then append content from each source file
clearDestination((clearErr) => {
  if (clearErr) {
    console.error('Error clearing destination file:', clearErr);
  } else {
    let currentIndex = 0;

    function appendNext() {
      if (currentIndex < sourceFilePaths.length) {
        const sourcePath = sourceFilePaths[currentIndex];
        currentIndex++;

        appendToFile(sourcePath, destinationFilePath, (err) => {
          if (err) {
            console.error(`Error appending content from ${sourcePath}:`, err);
          } else {
            console.log(
              `Content from ${sourcePath} appended to ${destinationFilePath} successfully!`
            );
          }

          // Append content from the next file
          appendNext();
        });
      } else {
        console.log('All files appended to the destination file.');
      }
    }

    // Start appending content from files
    appendNext();
  }
});
