import gdata.service
import gdata
import atom
import logging
class Blogger :
    def __init__(self, username, password):
        self.username = username
        self.password = password
        blogger_client = gdata.service.GDataService(username +'@gmail.com', password)
        blogger_client.ssl = False
        blogger_client.service = 'blogger'
        blogger_client.account_type = 'GOOGLE'
        blogger_client.server = 'www.blogger.com'
        blogger_client.ProgrammaticLogin(username, password)
        self.client = blogger_client

    def GetUserBlogTitles(self) :
        feed = blogger_client.Get('/feeds/default/blogs')
        blogs = []
        for blog in feed.entry :
            blogs.append(blog.title.text)
            return blogs

    def CreatePublicPost(self, blog_id, title, content):
        entry = gdata.GDataEntry()
        entry.title = atom.Title('xhtml', title)
        entry.content = atom.Content(content_type='html', text=content)
        logging.info("Published key added")
        """TODO : Get current date time stamp for Published """
        entry.published = atom.Published('xhtml', '2010-08-01')
        return self.client.Post(entry, "/feeds/%s/posts/default" % blog_id)

    def CreateDraftPost(self, blog_id, title, content):
        entry = gdata.GDataEntry()
        entry.title = atom.Title('xhtml', title)
        entry.content = atom.Content(content_type='html', text=content)
        control = atom.Control()
        control.draft = atom.Draft(text='yes')
        entry.control = control
        return self.client.Post(entry, "/feeds/%s/posts/default" % blog_id)

    def GetBlogId(self, blog_name) :
        feed = self.client.Get('/feeds/default/blogs')
        blogs = []
        for blog in feed.entry :
            if (blog.title.text == blog_name) :
                blog_id = blog.GetSelfLink().href.split("/")[-1]
                return blog_id
        return None



