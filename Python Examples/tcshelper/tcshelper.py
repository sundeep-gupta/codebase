#!/usr/bin/env python
# Copyright (c) 2011, Bubble Inc., All rights reserved.
import sys
import re
import pprint
import os


class TopcoderFile :
    """Utility class for performing mundane tasks of
    TopCoder development project
    @author Sundeep Gupta
    @version 1.0
    """

    def __init__(self, filename, designer, version, width=4, line_limit = 120,
                  copyright = 'Copyright (c) 2011, TopCoder, Inc. All rights reserved.') :
        """
        Parameters :
        filename : name of the file on which operations are performed.
        designer : The name of the designer for '@author' tag
        version : The version number for '@version' tag.
        width : The number of spaces to be used for each '\t' replacement (default is 4)
        line_limit : The maximum number of characters per line (default is 120)
        """
        if not os.path.isfile(filename) :
            raise "FileNotFoundException"
        
        # Hold the values in the attributes.
        self.width = width
        self.limit = line_limit
        self.filename = filename
        self._copyright = ['/**', ' * ' + copyright, ' */']
        self._author = designer + ', TCSDEVELOPER'
        self.version = version
        
        # Open the file and save the initial lines. Also remove the newline characters at the end for all lines.
        fh = open(self.filename, 'r')
        self.data = fh.readlines()
        fh.close()
        self.data = [ line.rstrip("\r\n") for line in self.data ]

    def add_version(self) :
        """Adds the @version tag to the class javadoc"""
        self.add_comments_before_class([' * @version ' + self.version ])

    def add_author(self) :
        self.add_comments_before_class([' * @author ' + self._author])

    def add_comments_before_class(self, comments) :
        comments_exist = []
        for i in range(0, len(comments)):
            comments_exist.append(False)

        jdoc = comment = False
        jdoc_begin = jdoc_end = class_pos = -1
        for i in range(0, len(self.data)) :
            # Check if we are entering the javadoc.
            if not jdoc and  re.match("^\s*/\*\*", self.data[i]) is not None :
                """We are inside the javadoc comments now."""
                jdoc_begin = i
                jdoc = True
                continue
            elif jdoc :
                if re.search("\*/", self.data[i]) is not None :
                    """ If we are at end of javadoc."""
                    jdoc_end = i
                    jdoc = False
                else:
                    """Check if the javadoc has the 'comments' we are looking to add. """
                    for idx in range(0, len(comments)) :
                        if not comments_exist[idx] and re.search(comments[idx], self.data[i]) is not None:
                            """ We found the comment in javadoc so we won't write it again """
                            comments_exist[idx] = True
                            break
                continue
            if not comment and re.match("^\s*/\*", self.data[i]) is not None:
                """We are inside the multiline comments """
                comment = True
                continue
            if comment and re.match("\*/", self.data[i]) is not None :
                """If we are inside comments, wait till we end the comment section """
                comment = False
                continue
            if not jdoc and not comment:
                """If we are not in any type of comment block, check if we reached the class definition"""
                if re.match('^\s*public\s+.*class\s+', self.data[i]) is not None or \
                        re.match('^\s*public\s+.*interface', self.data[i]) is not None :
                    """ we found the class or interface declaration, time for coming out of loop."""
                    class_pos = i
                    # Do we already have comments ?
                    if jdoc_begin == -1 :
                        """We do not have class/interface javadoc"""
                        comments = ['/**', ' *'] + comments + [' */']
                        comments.reverse()
                        for line in comments :
                            self.data.insert(i , line)
                    else :
                        """Remove the comments which already exist and add remaining to javadoc
                        NOTE: We are not preserving the order of comments..."""
                        comments = [comments[idx] for idx in range(0, len(comments)) if comments_exist[idx]]
                        for line in comments:
                            self.data.insert(jdoc_end, line)
                    break
        else :
            if jdoc :
                print "Considering error as jdoc was not closed"
            print "No class definition found, hence not adding version for file " + self.filename
            return
        # We come here only when we do a 'break' and we do that when we successfully 
        # add the comment.
        return 

        

    def replace_tabs(self) :
        """Replaces tabs with spaces in the given data
        @return the new data with tabs replaced with spaces.
        """
        self.data = [ re.sub("\t", "    ", line) for line in self.data ]

    def wrap_lines(self) :
        """
        Function to wrap the data to 120 character limit.
        """
        _data = []
        for line in self.data :
            # TODO : Write code to handle the comments and code differently to breaking into 
            # multiple lines
            _data = _data +  self.__break_lines__(line)
        self.data = _data[:]

    def __break_lines__(self, line) :
        
        """
        Start from 0 and continue till limit or end of line.
        if Limit reached, backtrace to the last whitespace char
        and that is the pos now for next iteration.
        """

        # If current line is < limit characters, return it.
        if(len(line) < self.limit) :
            return [line]
        
        # Check if the current line is part of multiline comment
        # If yes we need to prepend <spaces> followed by '*' to each line.
        is_comment = False
        comment_str = None
        m = re.match("^(\s+\*)", line)
        if m is not None:
            is_comment = True
            comment_str = m.group(1)

        # Start dividing the line into multiple lines
        _lines = []
        pos = bp = start = count = 0
        while pos < len(line) :
            if line[pos] in [' ', ',', '.'] :
                bp = pos
            if count >= self.limit :
                if start > 0 and is_comment :
                    _lines.append( comment_str + line[start:bp])
                    count = len(comment_str)
                else :
                    _lines.append( line[start:bp] )
                    count = 0
                start = pos = bp
            count += 1
            pos += 1
        
        # Append the remaining part of line.
        if len(_lines) > 0 and is_comment :
            _lines.append( comment_str + line[start:len(line)])
        else :
            _lines.append(line[start:len(line)])

        # Finally returning the list of lines.
        return _lines


    def remove_trailing_spaces(self) :
        self.data = [ re.sub("\s+$", "", line) for line in self.data ]


    def insert_copyright(self) :
        # Check if copyright is present.
        for line in self.data :
            if re.search('Copyright\s+\d+,\s+TopCoder', line) :
                break
        else :
            self.data = self._copyright + self.data

    def save(self) :
        fh = open(self.filename, 'w')
        for line in self.data :
            fh.write(line + "\n")
        fh.flush()
        fh.close()

    def indentate(self) :
        """Crucial function to indentate the code"""
        level = 0 
        # Here we process assuming '{' at end means new block and '}' implies block end
        # No more complexity is handled. Hope this message is clear.
        for i in range(0, len(self.data)) :
            if re.search('\{\s*$', self.data[i]) is not None :
                self.data[i] = " " * 4 * level + self.data[i].lstrip()
                level = level + 1
                continue
            elif re.search('\}\s*$', self.data[i]) is not None :
                level = level - 1
            self.data[i] = ' ' * 4 * level + self.data[i].lstrip()
            
    def add_throws(self) :
        """Add @throws tag at correct location but not remove from incorrect location"""
        self.__add_tags__('Exceptions:', '@throws')

    def add_param(self) :
        """Add @param tag at correct location but not remove from incorrect location"""
        self.__add_tags__('Params:', '@param')

    def add_return(self) :
        """Add @return tag at correct location but not remove from incorrect location"""
        self.__add_tags__('Returns:', '@return')
           
    def __add_tags__(self, section, tag):
        """Topcoder file by default will not have correct @param. The file usually will have
            'Params:' section seperate and the '@params' tag seperate. This function is 
            to correct that issue of TopCoder UML Tool
        """
        # Assuming that the block start is 'Params:' and end is a blank line comment. 
        # This code will add '@param to each line after 'Params :', till it finds a blank line of comment.
        section_found = False
        section_line = -1
        regex = '^\s*\*\s+' + section + '\s*$'
        for i in range(0, len(self.data)) :
            if not section_found and re.match(regex, self.data[i]) is not None :
                section_line = i
                section_found = True
            elif section_found :
                # If empty comment line, we reached end of section.
                if re.match('^\s*\*/?\s*$', self.data[i]) is not None :
                    section_found = False
                else :
                    begin_loc = self.data[i].find('*')
                    if begin_loc == -1 :
                        print "Unable to find comment, we should not have reached here - " + str(i)
                    else :
                        if re.search(tag, self.data[i]) is None :
                            print 'Adding ' + str(i)
                            self.data[i] = self.data[i][0: begin_loc + 1] + ' ' + tag + ' ' + self.data[i][begin_loc + 1 :]
                        else :
                            print "Already tag exists - %s " % self.data[i]
        return None

if __name__ == '__main__' :
    topcoderFile = TopcoderFile(sys.argv[1], 'nhzp339', '1.0')
    topcoderFile.add_param()
    topcoderFile.add_return()
    topcoderFile.add_throws()
    topcoderFile.insert_copyright()
    topcoderFile.add_version()
    topcoderFile.add_author()
    
    # Here onwards we change the format of code.
    topcoderFile.wrap_lines()
    topcoderFile.indentate()
    topcoderFile.remove_trailing_spaces()
    
    # save the file 
    topcoderFile.save()




