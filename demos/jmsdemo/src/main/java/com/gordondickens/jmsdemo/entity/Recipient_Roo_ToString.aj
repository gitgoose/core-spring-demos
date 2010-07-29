package com.gordondickens.jmsdemo.entity;

import java.lang.String;

privileged aspect Recipient_Roo_ToString {
    
    public String Recipient.toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Id: ").append(getId()).append(", ");
        sb.append("Version: ").append(getVersion()).append(", ");
        sb.append("SenderEmail: ").append(getSenderEmail()).append(", ");
        sb.append("SenderFirstName: ").append(getSenderFirstName()).append(", ");
        sb.append("SenderLastName: ").append(getSenderLastName()).append(", ");
        sb.append("RecipientEmail: ").append(getRecipientEmail()).append(", ");
        sb.append("RecipientFirstName: ").append(getRecipientFirstName()).append(", ");
        sb.append("RecipientLastName: ").append(getRecipientLastName()).append(", ");
        sb.append("Subject: ").append(getSubject()).append(", ");
        sb.append("MessageBody: ").append(getMessageBody());
        return sb.toString();
    }
    
}
