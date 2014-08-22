import smtplib  
from email.mime.text import MIMEText  
mailto_list=["xxxxx"] 
mail_host="smtp.qq.com"
mail_user="xxxxxx" 
mail_pass="xxxxx"
mail_postfix="qq.com"
  
def send_mail(to_list,sub,content):
    me="kevin"+"<"+mail_user+"@"+mail_postfix+">"
    msg = MIMEText(content,_subtype='html',_charset='gb2312')
    msg['Subject'] = sub
    msg['From'] = me  
    msg['To'] = ";".join(to_list)  
    try:  
        s = smtplib.SMTP()  
        s.connect(mail_host)
        s.login(mail_user,mail_pass)
        s.sendmail(me, to_list, msg.as_string())
        s.close()  
        return True  
    except Exception, e:  
        print str(e)  
        return False  
        
if __name__ == '__main__':  
   send_mail(mailto_list,"xxxxx","test"):  
    