import gdata.photos.service
import gdata.photos
#import gdata.media
#import gdata.geo
import sys

def GetService(username, password) :
    # Get the photoService Object
    pws = gdata.photos.service.PhotosService()
    pws.ssl = False
    pws.ClientLogin(username, password)
    return pws

def GetAlbumsList(service) :
    albums = service.GetUserFeed().entry
    return albums

def GetAllPhotoes(service, album_name) :
    albums = GetAlbumsList(service)
    for album in albums :
        print album.title.text
        if album.title.text == album_name :
            photos = service.GetFeed(album.GetPhotosUri()).entry
            return photos
    return None

service = GetService('code.script@gmail.com', 'SCJP+scwcd5')

photos = GetAllPhotoes(service, 'Jyothika')

print photos[0].title.text
sys.exit(0)


    # Get all albums
#    albums = service.GetUserFeed().entry

# Get all photos in second album
#photos = pws.GetFeed(albums[1].GetPhotosUri()).entry
#photo = photos[0]
#print photo.GetAlbumUri()
#print photo.title.text
#print photo.content.src
#<a onblur="try { parent.deselectBloggerImageGracefully();} catch(e) {}" 
#   href="http://3.bp.blogspot.com/_N2_kyOe5r1E/TDATpctbJxI/AAAAAAAAADc/lHTeLbtlKoA/s1600/A1.jpg">
#<img style="cursor:pointer; cursor:hand;width: 400px; height: 345px;" 
#     src="http://3.bp.blogspot.com/_N2_kyOe5r1E/TDATpctbJxI/AAAAAAAAADc/lHTeLbtlKoA/s400/A1.jpg" 
#     border="0" 
#     alt=""
#     id="BLOGGER_PHOTO_ID_5489909548566914834" />
#</a>
#print photo.id.text
#print "photo.gphoto_id " 
#print photo.gphoto_id
#print "GetMediaURL"
#print photo.GetMediaURL()
#print photo.position.text
#print photo.commentingEnabled
## tags = pws.GetFeed(albums[1].GetTagsUri()).entry
# print [ tag.summary.text for tag in tags ]
# Get all comments for the first photos in list and print them
# comments = pws.GetCommentFeed(photos[0].GetCommentsUri()).entry
# print [ c.summary.text for c in comments ]

#albumidlist = []
#index = 0
# add each album in the list
#for album in albums :
#    index = index + 1
#    albumidlist.append(album.gphoto_id)
#    print '%d %s' %(index,album.title.text)

#sys.exit(1)

#album = gd_client.InsertAlbum(title='New album', summary='This is an album')

#sys.exit(1)
#albums = gd_client.GetUserFeed()
#for album in albums.entry:
#    print 'title: %s, number of photos: %s, id: %s' % (album.title.text,
#            album.numphotos.text, album.gphoto_id.text)
