public class ParseXml {
    
    public static StsCredentials getNodeValues(){
        StsCredentials credentials = new StsCredentials();
    string response = '<AssumeRoleWithWebIdentityResponse xmlns="https://sts.amazonaws.com/doc/2011-06-15/"><AssumeRoleWithWebIdentityResult> <SubjectFromWebIdentityToken>amzn1.account.AF6RHO7KZU5XRVQJGXK6HB56KR2A</SubjectFromWebIdentityToken> <Audience>client.5498841531868486423.1548@apps.example.com</Audience> <Credentials> <SessionToken>AQoDYXdzEE0a8ANXXXXXXXXNO1ewxE5TijQyp+IEXAMPLE</SessionToken> <SecretAccessKey>wJalrXUtnFEMI/K7MDENG/bPxRfiCYzEXAMPLEKEY</SecretAccessKey> <Expiration>2014-10-24T23:00:23Z</Expiration> <AccessKeyId>ASgeIAIOSFODNN7EXAMPLE</AccessKeyId> </Credentials> </AssumeRoleWithWebIdentityResult> </AssumeRoleWithWebIdentityResponse>';
        Dom.Document docx = new Dom.Document(); 
        docx.load(response);
        dom.XmlNode rootelement = docx.getrootelement() ;
        for(dom.XmlNode childelement : rootelement.getChildElements()){
            for ( Dom.XMLNode detailElement : childElement.getChildElements() ) {
                for(Dom.XMLNode grandchild : detailElement.getChildElements()){
                     if('SessionToken'.equalsIgnoreCase(grandchild.getName())){
                        credentials.sessionToken = grandChild.getText();
                }
                else if('SecretAccessKey'.equalsIgnoreCase(grandchild.getName())){
                     credentials.SecretAccessKey = grandChild.getText();
                }
                else if('AccessKeyId'.equalsIgnoreCase(grandchild.getName())){
                     credentials.AccessKeyId = grandChild.getText();
                }
               }
            } 
        }
        return credentials;
    }
    
    public class StsCredentials{
        public string SessionToken{get;set;}
        public string SecretAccessKey{get;set;}
        public string AccessKeyId{get;set;}
    }
}