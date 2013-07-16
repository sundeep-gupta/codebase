<?php
/**
 * @version        $Revision: 322 $
 * @package        Joomla Article ToC
 * @subpackage     Content
 * @copyright      Copyright (C) 2009 Straton IT
 * @license        GNU/GPL, see LICENSE.php
 * Joomla! is free software. This version may have been modified pursuant
 * to the GNU General Public License, and as distributed it includes or
 * is derivative of works licensed under the GNU General Public License or
 * other free or open source software licenses.
 * See COPYRIGHT.php for copyright notices and details.
 */

// Check to ensure this file is included in Joomla!
defined( '_JEXEC' ) or die( 'Restricted access' );

jimport( 'joomla.plugin.plugin' );

/**
 * Display the TOC for articles with headers
 *
 * @package        Joomla
 * @subpackage     Content
 * @since          1.5
 */
class plgContentToc extends JPlugin
{
    /**
     * Example prepare content method
     *
     * Method is called by the view
     *
     * @param     object        The article object.  Note $article->text is also available
     * @param     object        The article params
     * @param     int            The 'page' number
     */
    function onPrepareContent( &$article, &$params, $limitstart )
    {
        // Get Plugin info
        $plugin            =& JPluginHelper::getPlugin('content', 'toc');
        $pluginParams    = new JParameter( $plugin->params );

        if (!$pluginParams->get('enabled', 1)) {
            return true;
        }

        if ( preg_match( '/<!--\\s*ArticleToc\\s*:\\s+enabled\\s*=\\s*no\\s*-->/i', $article->text ) ) {
            return true;
        }
        // simple performance check to determine whether bot should process further
        if ( !preg_match( '/<h[1-6]/i', $article->text ) ) {
            return true;
        }

        $view  = JRequest::getCmd('view');

        // check whether plugin has been unpublished
        if (!JPluginHelper::isEnabled('content', 'toc') || $params->get( 'intro_only' )|| $params->get( 'popup' ) || $view != 'article') {
            return;
        }

        // Build the page structure and proceed to the required content substitution
        $structure = new plgContentTocArticleStructure( array( 'addNumbering' => $pluginParams->get( 'addNumbering', true ) ) );
        $structure->processArticle( $article->text );

        // Create the $article->toc field
        if ( $pluginParams->get( 'addToc', true ) )
            $this->createToc( $article, $structure );

        return true;
 
    }

    function createToc( &$article, $structure )
    {

        $plugin =& JPluginHelper::getPlugin('content', 'toc');
        $pluginParams = new JParameter( $plugin->params );
        $document =& JFactory::getDocument();

        if ($pluginParams->get( 'indentToc', true ) )
        {
            $document->addStyleSheet( 'plugins/content/toc.css' );
        }

        if ( $pluginParams->get( 'displayToc') == 'table')
        {
            $this->createTableToc( &$article, $structure);
        }
        elseif ( $pluginParams->get( 'displayToc' ) == 'drop_down' )
        {
            $document->addScript( 'plugins/content/toc.js' );
            $this->createDropDownToc( &$article, $structure );
        }
    }

    function createTableToc( &$article, $structure )
    {
        $article->toc = '
        <table cellpadding="0" cellspacing="0" class="contenttoc">
        <tr>
            <th>'
            . JText::_( 'Article Index' ) .
            '</th>
        </tr>
        ';

        foreach ( $structure->headings() as $heading )
        {
            $article->toc .= '
                <tr>
                    <td>
                    <a href="#'. $heading['anchor'] .'" class="toclink toclink-h'. $heading['level'].'">'
                    . $heading['contents'] .
                    '</a>
                    </td>
                </tr>
                ';
        }

        $article->toc .= '</table>';
    }

    function createDropDownToc( &$article, $structure )
    {
        $article->toc = '
        <form action="#">
        <select name="contenttoc_menu" onchange="menu_goto( this.form )">
            <option selected value="">'. JText::_( 'Article Index' ) .'</option>
        ';

        foreach ( $structure->headings() as $heading )
        {
            $article->toc .= '
                <option value="#'.$heading['anchor'].'" class="toclink toclink-h'. $heading['level'].'">'. $heading['contents'] .'</option>';
        }

        $article->toc .= '</select></form>';
    }
}

class plgContentTocArticleStructure
{
    private $number, $headings;
    private $addNumbering = false;
    private static $regex;
    private static $regex_matched_cleanly;
    private static $regex_matched_loosely;

    function plgContentTocArticleStructure( $options )
    {
        if ( isset ( $options['addNumbering'] ) )
        {
            $this->addNumbering = !!$options['addNumbering'];
        }

        if ( !isset( self::$regex ) )
        {
            self::$regex = '#'
                .'( <h([1-6]) [^>]* ) >'  // <hN>, $1 is <hN attr="val"   $2 is N
                .'( [^<>]+ )'             // content $3, may not be empty or contain more tags
                .'( </h\\2> )'            // matching </hN> $4
                .'|'                      // OR: looser match below
                .'( <h([1-6]) [^>]* ) >'  // idem, $5, $6
                .'( .*? (?: \\n .*? )? )' // content $7, anything on 2 lines max
                .'( </h\\6> )'            // idem, $8
                .'#ix';

            self::$regex_matched_cleanly = 1; # $1 ..
            self::$regex_matched_loosely = 5; # $5 ..
        }
    }

    function processArticle( &$articleText )
    {
        $this->number = array( 0 );
        $this->headings = array();

        $articleText = preg_replace_callback( self::$regex, array( $this, 'headingReplaceCallback' ), $articleText );
    }

    function headingReplaceCallback( $matches )
    {
        if ( $matches[ self::$regex_matched_cleanly ] )
            $matches_index = self::$regex_matched_cleanly;
        else
            $matches_index = self::$regex_matched_loosely;

        list( $opening, $level, $contents, $closing ) = array_slice( $matches, $matches_index, 4 );
        $text_contents = preg_replace( '# < [^>]+ > | \\n #x', '', $contents);

        $this->incrementNumber( $level );

        $anchorMatches = array();
        if ( preg_match( '/id=([\'"])([^\\1]*)\\1/i', $opening, $anchorMatches ) )
        {
            $anchor = $anchorMatches[2];
        }
        else
        {
            $anchor = join( '-', $this->number ) . '-' . JFilterOutput::stringURLSafe( $text_contents );
            $opening .= " id='$anchor'";
        }

        $numbering = $this->addNumbering ? join( '.', $this->number ) . '.&nbsp;' : '';

        $this->headings[] = array( 'number' => $this->number, 'contents' => "$numbering$text_contents", 'anchor' => $anchor, 'level' => $level );

        return "$opening>$numbering$contents$closing";
    }

    function incrementNumber( $level )
    {
        if ( $level > count( $this->number ) )
        {
            $this->number = array_pad( $this->number, $level, 1 ); // New sublevel(s)
        }
        else
        {
            while ( $level < count( $this->number ) )
                array_pop( $this->number ); // Up a level, as much as needed

            $this->number[ count( $this->number ) - 1 ]++; // increment last digit
        }
    }

    function headings()
    {
        return $this->headings;
    }
}

?>
