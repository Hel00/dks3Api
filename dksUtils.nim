import winim

proc GetKey*(vKey: int32): bool {.stdcall, dynlib: "user32", importc: "GetAsyncKeyState".}

# Function that just get's an offset, basically like cheat engine does
# usage will explain gud
proc getOffset*(processHandle: HANDLE, offsets: seq[int64]): int64 =
  var
    value: int64
  for i in 0 .. offsets.len - 1:
    discard ReadProcessMemory(processHandle, cast[LPVOID](value + offsets[i]), LPVOID(addr(value)), SIZE_T(sizeof(value)), nil)
  return value

let
  processHandle* = GetCurrentProcess()
  # Bases
  BaseA*: int64 = 0x144740178
  BaseB*: int64 = 0x144768E78
