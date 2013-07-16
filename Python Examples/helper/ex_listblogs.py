#!/usr/bin/python
import sys
import os

sys.path.append(os.path.dirname(sys.argv[0]) + '../google')
import Blogger
import Picasa

def PrintAllPosts(blogger_service, blog_id):
  feed = blogger_service.GetFeed('/feeds/' + blog_id + '/posts/default')
  print feed
  sys.exit(1)
  print feed.title.text
  for entry in feed.entry:
    print "\t" + entry.title.text
 #   print "\t" + entry.content.text
    print "\t" + entry.updated.text
  print

username='code.script@gmail.com'
password='SCJP+scwcd5'
service = Blogger.GetBloggerService(username, password)
blog_id = Blogger.GetUserBlogTitles(service)
if blog_id is None :
        print "Failed to create blog"
        sys.exit(1)
print blog_id
#PrintAllPosts(service, blog_id)




username = 'code.script'
password = 'SCJP+scwcd5'
folder   = 'Lara Dutta'
picasa = GetPicasaService(username, password)
photos = GetAllPhotoes(picasa, folder) 
content = ''
for photo in photos :
    img = photo.GetMediaURL()
    id  = photo.id.text
    content = content + "\n" + '<a onblur="try { parent.deselectBloggerImageGracefully();} catch(e) {}" ' \
            + ' href="' + img + '">'\
            + '<img style="cursor:pointer; cursor:hand;width: 400px; height: 345px;" '\
            + ' src="' + img + '"'\
            + ' border="0"  alt="" id="BLOGGER_PHOTO_ID_' + id + '" /></a>'

blogger = GetBloggerService(username, password)
print GetUserBlogTitles(blogger)
blog_id = GetBlogId(blogger, 'Bollywood Actress Pics')
if blog_id is not None :
    print CreatePublicPost(blogger, blog_id, folder, content)

sys.exit(1)
