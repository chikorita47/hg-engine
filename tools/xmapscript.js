const fs = require('fs');
const inquirer = require('../squirdle/node_modules/inquirer');

const romLd = fs.readFileSync('./rom.ld', 'utf-8');
const romLdSplit = romLd.split('\n');

const xmap = fs.readFileSync('/Users/eric2/Downloads/main.nef.xMAP', 'utf-8');
const xmapSplit = xmap.split('\n');

const regex = /^[0-9A-F]{8}$/;

(async () => {
  for (let i = 0; i < romLdSplit.length; i++) {
    const line = romLdSplit[i];
    if (!line || line.startsWith('/*')) {
      console.log('skipping empty line');
      continue;
    }
    if (line.includes('/*pt*/')) {
      console.log('skipping already converted line');
      continue;
    }
    if (!line.includes(' = ')) {
      console.log('skipping', line);
      continue;
    }
    const functionName = line.split(' = ')[0];
    console.log('searching xmap for', functionName);
    let matchedLines = []
    xmapSplit.forEach(xmapLine => {
      if (xmapLine.includes(functionName)) {
        matchedLines.push(xmapLine);
      }
    });
    if (!matchedLines.length) {
      console.log('no match found, continuing...');
      continue;
    }
    const allMatchedLines = matchedLines.join('\n');
    console.log(allMatchedLines);
    const { address } = await inquirer.prompt({
      type: 'input',
      name: 'address',
      message: 'Use address:',
      validate: input => !input || input === 'quit' || (regex.test(input) && allMatchedLines.includes(input))
    });
    if (address === 'quit') break;
    if (!address) continue;
    const newLine = `${functionName} = 0x${address} | 1; /*pt*/`;
    console.log('replacing line with', newLine);
    romLdSplit[i] = newLine;
  }

  fs.writeFileSync('./rom.ld', romLdSplit.join('\n'), 'utf-8');
})();
