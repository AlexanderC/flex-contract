const resolve = require('snyk-resolve');
 
try {
  console.log(resolve.sync(process.argv[2], process.cwd()));
} catch (e) {
  console.error(`ERROR: ${e.message}`);
  process.exit(1);
}

process.exit(0);
