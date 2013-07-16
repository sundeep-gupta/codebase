import Picasa
import Blogger
import os
import sys
import re

username = 'sundeep.753'
password = 'SCJP+scwcd5'
if len(sys.argv) != 2 : 
    print "Please provide the directory where jpeg/jpg files are present"
    sys.exit(1)

folder   = sys.argv[1]
if not os.path.isdir(folder) :
    print "You need to specify directory, Nothing else would work"
    sys.exit(1)

###### Code to login into picasa ###################
picasa = Picasa.GetPicasaService('code.script', password)

###### CODE TO CREATE ALBUM AND ADD PICS #########
#album = Picasa.CreateNewAlbum(picasa, folder)
#print "GPHOTO_ID" + album.gphoto_id.text
#print "NAME " + album.name.text
album_name = os.path.basename(folder)
###### CODE TO DELETE EMPTY ALBUMS ##############
# Picasa.DeleteAllEmptyAlbums(picasa)

###### Code to login into blogger ##################
blogger = Blogger.GetBloggerService(username, password)
#print Blogger.GetUserBlogTitles(blogger)

###### CODE TO GET ALL PHOTOS FROM GIVEN ALBUM NAME ########
photos = Picasa.GetAllPhotoes(picasa, album_name)


######## NOW CREATE BLOG CONTENT #################
blog_id = Blogger.GetBlogId(blogger, 'Bollywood Actress Pics')
if blog_id is None :
        print "Failed to create blog"
        sys.exit(1)
content = ''
i = 0
limit = 5
total = len(photos)
print total
for photo in photos :
    img = photo.GetMediaURL()
    id  = photo.id.text
    m = re.search('.*\/(\d+)$/', id)
    if m is not None :
        id = m.group(1)

    content = content + "\n" + '<a onblur="try { parent.deselectBloggerImageGracefully();} catch(e) {}" ' \
            + ' href="' + img + '">'\
            + '<img style="cursor:pointer; cursor:hand;width: 400px; height: 345px;" '\
            + ' src="' + img + '"'\
            + ' border="0"  alt="" id="BLOGGER_PHOTO_ID_' + id + '" /></a><br/><br/>'
    i = i + 1
    if i == limit :
        i = 0
        new_blog = Blogger.CreatePublicPost(blogger, blog_id, album_name, content)
        if new_blog is not None :
            print "Blog created successfully."
        else :
            print "Failed to create blog" 
        content = ''
if content == '' :
    sys.exit(1)
new_blog = Blogger.CreateDraftPost(blogger, blog_id, album_name , content)
if new_blog is not None :
    print "Blog created successfully."
else :
    print "Failed to create blog" 


