
* To prevent symbol / memory usage attacks against this, I should adjust the
  constant lookup to whitelist and compare the constants as strings before
  getting the constant.
* Apparently string reuse is better done through constants to prevent them
  from being recreated all the time such as accessing common hash keys, think
  'path', 'from', 'value', 'op'.
* The big one: Generation of patches based on the difference of two provided
  hashes.

