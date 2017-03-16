require! {
  espree
}

walk = require 'esprima-walk'

list_requires = (code) ->
  parsed = espree.parse code, {
    tolerant: true
    ecmaVersion: 8
  }
  output = []
  output_set = {}
  walk parsed, (node) ->
    if node?type == 'CallExpression' and node?callee?type == 'Identifier' and node?callee?name == 'require'
      value = node?arguments?0?value
      if not output_set[value]
        output.push value
        output_set[value] = true
  return output

module.exports = list_requires
