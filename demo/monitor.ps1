$PrevLWT = @(Get-ChildItem -Recurse -File .\src\; Get-ChildItem -Recurse -File ..\src\);

while (1) {
  sleep(1);

  $NextLWT = @(Get-ChildItem -Recurse -File .\src\; Get-ChildItem -Recurse -File ..\src\);

  if (Compare-Object -Property LastWriteTime $PrevLWT $NextLWT) {
    sauer make;

    $PrevLWT = $NextLWT;
  }
}

