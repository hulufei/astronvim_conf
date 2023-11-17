-- [nfnl] Compiled from util.fnl by https://github.com/Olical/nfnl, do not edit.
local fun = require("user.vendor.fun")
local function autoload(name)
  local res = {["aniseed/autoload-enabled?"] = true, ["aniseed/autoload-module"] = false}
  local function ensure()
    if res["aniseed/autoload-module"] then
      return res["aniseed/autoload-module"]
    else
      local m = require(name)
      do end (res)["aniseed/autoload-module"] = m
      return m
    end
  end
  local function _2_(_t, ...)
    return ensure()(...)
  end
  local function _3_(_t, k)
    return ensure()[k]
  end
  local function _4_(_t, k, v)
    ensure()[k] = v
    return nil
  end
  return setmetatable(res, {__call = _2_, __index = _3_, __newindex = _4_})
end
local function last(xs)
  return fun.nth(fun.length(xs), xs)
end
local function reverse(xs)
  local len = fun.length(xs)
  local function _5_(n)
    return fun.nth((len - n), xs)
  end
  return fun.take(fun.length(xs), fun.tabulate(_5_))
end
local function tx(...)
  local args = {...}
  local len = fun.length(args)
  if ("table" == type(last(args))) then
    local function _6_(acc, n, v)
      acc[n] = v
      return acc
    end
    return fun.reduce(_6_, last(args), fun.zip(fun.range(1, len), fun.take((len - 1), args)))
  else
    return args
  end
end
local function get_input(prompt, completion)
  local ok, result = pcall(vim.fn.input, {prompt = prompt, completion = completion, cancelreturn = vim.NIL})
  if (ok and (result ~= vim.NIL)) then
    return result
  else
    return nil
  end
end
local function get_vselect_text()
  local _, row, start = unpack(vim.fn.getpos("'<"))
  local _0, _1, _end = unpack(vim.fn.getcharpos("'>"))
  local row0 = (row - 1)
  local start0 = (start - 1)
  local _end0 = vim.fn.byteidx(unpack(vim.api.nvim_buf_get_lines(0, row0, (row0 + 1), nil)), _end)
  return unpack(vim.api.nvim_buf_get_text(0, row0, start0, row0, _end0, {}))
end
return {autoload = autoload, tx = tx, ["get-input"] = get_input, ["get-vselect-text"] = get_vselect_text, last = last, reverse = reverse}
