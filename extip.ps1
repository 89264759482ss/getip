$wc = new-object System.Net.WebClient

$eip = $wc.DownloadString("http://myexternalip.com/raw")
$eip > C:\Users\furse\Gdisk\ExtIP\ip.txt

if ($eip -eq "") {$eip = "22.222.222.222"}

# Указываем путь к файлу
$pathToFile = "C:\Users\furse\Gdisk\ExtIP/MiniServ.rdp"

$Log = "C:\Users\furse\Gdisk\ExtIP\extip.log"

# Задаем шаблон для поиска в файле
# $pattern = "full address:s:"
$regex = "full address:s:(\d+\.\d+\.\d+\.\d+):(\d+)"

# Задаем строку, которой мы заменим найденную строку
$replacement = "full address:s:"+$eip+":7704"


# Читаем содержимое файла
$content = Get-Content -Path $pathToFile

# Заменяем строку по шаблону
$newContent = $content -replace $regex, $replacement

# Записываем измененное содержимое обратно в файл
$newContent | Set-Content -Path $pathToFile

$TimeNow = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# $TimeNow

cd C:\Users\furse\Gdisk\ExtIP

git add .

git commit -m $TimeNow 

$gstatus = git status

$TimeNow+" - "+$replacement+"`r`n"+$gstatus >> $Log

git push -u origin main



