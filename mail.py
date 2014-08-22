import smtplib  
from email.mime.text import MIMEText  
mailto_list=["kangwenyi@imfclub.com"] 
mail_host="smtp.qq.com"
mail_user="296853913" 
mail_pass="13546252421"
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
    if send_mail(mailto_list,"296853913@qq.com","aaaaaaaaaaaa"):  
        print 'OK'
    else:  
        print 'fullb'