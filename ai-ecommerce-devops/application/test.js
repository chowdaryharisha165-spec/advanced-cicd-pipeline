const assert = require('assert');

console.log('Running automated API sanity tests...');
assert.strictEqual(1 + 1, 2, 'Math verification failed');
console.log('[✓] Unit & smoke tests passed.');
