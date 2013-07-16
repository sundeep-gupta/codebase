
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.MalformedURLException;
import java.io.IOException;
import java.io.DataOutputStream;
import java.io.DataInputStream;
import java.io.OutputStreamWriter;

public class HTTP {
    StringBuffer sbHttpResponse;

    public HTTP() {
    }

    public String Get(String sUrl,String postData,String cookie1,String cookie2,String cookie3) throws MalformedURLException, IOException {
        String sHttpContent = null;
        byte sRespStr[];
        int i,len;
        String as;
        StringBuffer sbHttpContent;
        URL url = new URL(sUrl);
        HttpURLConnection httpurlcon = (HttpURLConnection) url.openConnection();
        httpurlcon.setDoOutput(true);
        httpurlcon.setRequestProperty("Cookie","user_id="+cookie1+"; browser_identifier="+cookie2+"; JSESSIONID="+cookie3);
        httpurlcon.connect();
        OutputStreamWriter wr = new OutputStreamWriter(httpurlcon.getOutputStream());
        wr.write(postData);
        wr.flush();
        if (httpurlcon.getResponseCode() ==200) {
            DataInputStream datout = new DataInputStream(httpurlcon.getInputStream());
            sRespStr = new byte[httpurlcon.getContentLength()];
            //sRespStr=null;
            datout.readFully(sRespStr);
            for(i=0,len=httpurlcon.getContentLength();i<len;i++){
                if(sRespStr[i]==0){
                    sRespStr[i] = 32;
                }
            }
            sHttpContent = new String(sRespStr);
            sRespStr = null;
            httpurlcon.disconnect();
            httpurlcon = null;
            wr.close();
            url = null;
        } else {
            throw new IOException("Status Code " + httpurlcon.getResponseCode() + " was received for " + sUrl);
        }
        return sHttpContent;
    }

  /* public static void main(String[] args) throws Exception {
        HTTP http = new HTTP();
        System.out.println("" + http.Get("http://65.216.69.22/edison/testdelivery/GMRT_3.lzx?__lzbc__=1146716286762" ,"fpv=8.22&ccache=false&lzr=swf7&trimwhitespace=true&sendheaders=false&reqtype=POST&cache=false&timeout=90000&lzt=data&url=http%3A%2F%2F65%2E216%2E69%2E22%2Fedison%2Ftestdelivery%2F%2E%2E%2FnextPage%2Ehtm%3FelapsedTime%3D0","70","150121d345","GTBpsGtQvJGjQBhVrtsL1kNykKvxDfchmpr2HBFtvyvtpgsGzh1r!344887589"));

    } */
}


