package com.dineth.ee.ejb;

import com.dineth.ee.model.Bid;
import jakarta.ejb.Singleton;

import java.util.*;

@Singleton
public class AuctionStatus {

    private final Map<String, Bid> highestBids = new HashMap<>();
    private final Map<String, List<Bid>> recentBids = new HashMap<>();
    private final Map<String, Boolean> auctionStatusMap = new HashMap<>();
    private final Map<String, Set<String>> itemUserMap = new HashMap<>();

    public synchronized String updateHighestBid(Bid bid){
        String itemId = bid.getItemId();

        if (!isAuctionOpen(itemId)) {
            return itemId;
        }

        Bid current = highestBids.get(itemId);
        if (current != null && bid.getAmount() <= current.getAmount()) {
            return itemId;
        }


        highestBids.put(itemId, bid);

        List<Bid> list = recentBids.computeIfAbsent(itemId, k -> new ArrayList<>());
        list.add(0, bid);

        if (list.size() > 6) {
            list.remove(list.size() - 1);
        }
        trackUser(bid.getItemId(), bid.getBidderName());
        return itemId;
    }
    public Bid getHighestBid(String itemId){

        return highestBids.get(itemId);
    }

    public Map<String, Bid> getHighestBids() {

        return highestBids;
    }

    public List<Bid> getRecentBidsForItem(String itemId) {
        return recentBids.getOrDefault(itemId, Collections.emptyList());
    }

    public Map<String, List<Bid>> getAllRecentBids() {

        return recentBids;
    }

    public void startAuction(String itemId) {

        auctionStatusMap.put(itemId, true);
    }

    public void closeAuction(String itemId) {

        auctionStatusMap.put(itemId, false);
    }

    public boolean isAuctionOpen(String itemId) {

        return auctionStatusMap.getOrDefault(itemId, false);
    }

    public Map<String, Boolean> getAllAuctionStatuses() {

        return auctionStatusMap;
    }

    public synchronized void trackUser(String itemId, String username) {
        itemUserMap.computeIfAbsent(itemId, k -> new HashSet<>()).add(username);
    }

    public Set<String> getUsersForItem(String itemId) {
        return itemUserMap.getOrDefault(itemId, Collections.emptySet());
    }

    public Map<String, Set<String>> getAllUserParticipation() {

        return itemUserMap;
    }

}
