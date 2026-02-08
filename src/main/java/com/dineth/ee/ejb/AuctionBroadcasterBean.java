package com.dineth.ee.ejb;

import com.dineth.ee.model.Bid;
import jakarta.ejb.ActivationConfigProperty;
import jakarta.ejb.EJB;
import jakarta.ejb.MessageDriven;
import jakarta.jms.JMSException;
import jakarta.jms.Message;
import jakarta.jms.MessageListener;
import jakarta.jms.ObjectMessage;

@MessageDriven(
        activationConfig = {
                @ActivationConfigProperty(propertyName = "destinationType", propertyValue = "jakarta.jms.Queue"),
                @ActivationConfigProperty(propertyName = "destinationLookup", propertyValue = "jms/BidQueue")
        }
)

public class AuctionBroadcasterBean implements MessageListener {
    @EJB
    private AuctionStatus auctionStatus;

    @Override
    public void onMessage(Message message) {
        try {
            if (message instanceof ObjectMessage) {
                ObjectMessage objectMessage = (ObjectMessage) message;
                Bid bid = (Bid) objectMessage.getObject();

                System.out.println("New bid received: ");
                System.out.println("Item ID: " + bid.getItemId());
                System.out.println("Bidder Name: " + bid.getBidderName());
                System.out.println("Bid Amount: " + bid.getAmount());

                String result = auctionStatus.updateHighestBid(bid);
                System.out.println("Bid result: " + result);
            }else {
                System.out.println("Invalid message received!");
            }
        } catch (JMSException e) {
            throw new RuntimeException(e);
        }
    }
}
