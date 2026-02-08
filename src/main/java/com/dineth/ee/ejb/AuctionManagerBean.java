package com.dineth.ee.ejb;


import com.dineth.ee.model.Bid;
import jakarta.annotation.Resource;
import jakarta.ejb.Stateless;
import jakarta.jms.*;

@Stateless
public class AuctionManagerBean {
    @Resource(lookup = "jms/BidQueue")
    private Queue bidQueue;
    @Resource(lookup = "jms/__defaultConnectionFactory")
    private ConnectionFactory connectionFactory;

    public String submitBid(Bid bid) {
        if (bid.getAmount() <= 0) {
            return "Bid amount must be greater than zero.";
        }

        try (JMSContext context = connectionFactory.createContext()) {
            ObjectMessage message = context.createObjectMessage(bid);
            context.createProducer().send(bidQueue, message);
            return "Bid submitted successfully!";
        }
    }
}
