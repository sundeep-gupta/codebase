import gdata.photos.service
import gdata.photos
import os
import logging

class Picasa :
    def __init__(self, username, password):
        self.username = username
        self.password = password
        self.client = gdata.photos.service.PhotosService()
        self.client.ssl = False
        self.client.ClientLogin(username + '@gmail.com', password)

    def GetAlbumsList(self) :
        return self.client.GetUserFeed().entry
    
    def GetAllPhotoes(self, album_name) :
        albums = self.GetAlbumsList()
        try :
            album = [a for a in albums if a.title.text == album_name][0]
            return self.client.GetFeed(album.GetPhotosUri()).entry
        except IndexError, ie:
            logging.info("IndexError occured.")
        return None
    
    def DeleteAllEmptyAlbums(self) :
        logging.debug('Getting list of all albums.')
        albums = self.GetAlbumsList()
        logging.debug('Filtering the empty albums.')
        empty_albums = [album for album in albums if len(self.client.GetFeed(album.GetPhotosUri()).entry) == 0]
        if len(empty_albums) == 0:
            logging.info('No empty album found.')
            return
        for album in empty_albums :
            logging.info("Deleting empty album - %s" % album.title.text)
            self.client.Delete(album)
    
    def CreateNewAlbum(self, folder, title = None, summary = None, location = None, access='public',
                       commenting = 'true', timestamp = None) :
        if not os.path.isdir(folder) :
            logging.error( "Argument 'folder' must be a directory")
            return None
        if title is None :
            if folder is None or len(folder) == 0 :
                title = 'Album created using python'
            else :
                title = os.path.basename(folder)
            logging.info("Setting title of album as %s" % os.path.basename(folder))
        if summary is None :
            summary = title
        
        new_album = self.client.InsertAlbum(title, summary, location, access, commenting, timestamp) 
        if new_album is None :
            logging.error( "Failed to create album")
            return None
        logging.info("Created album " + title)
        logging.info("Now Adding Pics")
        arg = { 'folder' : folder, 'album' : new_album , 'service' : self.client }
        os.path.walk(folder, self._insertPhoto, arg)
        return new_album
    
    def _insertPhoto(self, arg, dirname, files) :
        folder = arg['folder']
        if folder != dirname :
            return
        service = arg['service']
        album   = arg['album']
    
        for file in files :
            ext = os.path.splitext(file)[1]
            path = folder + "/" + file
            if os.path.isfile(path) and (ext.lower() == '.jpg' or ext.lower() == '.jpeg'):
                print "Added " + path
                service.InsertPhotoSimple(album, file, file, path)

if __name__ == '__main__' :
    obj = Picasa('sundeep.techie', 'gr33N!e.');
    obj.CreateNewAlbum("/media/sf_DATA/pictures/picasa/sundeep.techie/abeer", "Abeer", "Abeer @ 3 months", "Bangalore")
    

