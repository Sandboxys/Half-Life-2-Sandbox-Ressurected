local test = file.Find("addons/menu", true)

if test and #test > 0 then
    print("file.Find working!")
else
    print("file.Find found nothing!")
end