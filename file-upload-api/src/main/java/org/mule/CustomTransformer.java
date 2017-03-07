package org.mule;
import java.io.IOException;
import java.io.InputStream;
import javax.activation.DataHandler;
import org.mule.api.MuleMessage;
import org.mule.api.transformer.TransformerException;
import org.mule.config.i18n.MessageFactory;
import org.mule.transformer.AbstractMessageTransformer;
public class CustomTransformer extends AbstractMessageTransformer {
    @Override
    public byte[] transformMessage(MuleMessage message, String outputEncoding) throws TransformerException {
        try {
            DataHandler file = message.getInboundAttachment("file");
            final InputStream in = file.getInputStream();
			byte[] byteArray=org.apache.commons.io.IOUtils.toByteArray(in);
            return byteArray;
        }catch(IOException ioException){
        	throw new TransformerException(MessageFactory.createStaticMessage("Error while transforming"), ioException);
        } 
    }
}