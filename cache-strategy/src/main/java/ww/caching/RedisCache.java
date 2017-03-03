package ww.caching;

import java.io.Serializable;

import org.mule.api.MuleEvent;
import org.mule.api.MuleException;
import org.mule.api.store.ObjectStore;
import org.mule.api.store.ObjectStoreException;
import org.springframework.beans.factory.annotation.Value;
import org.mule.DefaultMuleMessage;
import org.mule.RequestContext;

import redis.clients.jedis.Jedis;

@SuppressWarnings("deprecation")
public class RedisCache<T extends Serializable> implements ObjectStore<T>{
	
	@Value("${redis.host}")
	private String host;
	@Value("${redis.port}")
	private int port;
	@Override
	public synchronized boolean contains(Serializable key) throws ObjectStoreException {
		// TODO Auto-generated method stub
		Jedis jedis = new Jedis(host, port);
		//System.out.println("inside contains method: test condition " + jedis.exists((String)key));
		return jedis.exists((String)key);	
	}

	@Override
	public synchronized void store(Serializable key, T value) throws ObjectStoreException {
		// TODO Auto-generated method stub
		Jedis jedis = new Jedis(host, port);
	    //jedis.auth("foobared");
	    //System.out.println("Connected to Redis inside store method" + "key: " + key + " value: " + value);
	    MuleEvent muleEvent =  (MuleEvent) value;
	    String payload = null;
		try {
			payload = muleEvent.getMessageAsString();
		} catch (MuleException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	    jedis.set((String)key, payload);
	}

	@SuppressWarnings({ "unchecked" })
	@Override
	public synchronized T retrieve(Serializable key) throws ObjectStoreException {
		
		MuleEvent muleEvent = RequestContext.getEvent( );
		//System.out.println("MuleEvent inside retrieve : "+ muleEvent);
		
		// TODO Auto-generated method stub
		if(contains(key))
		{	Jedis jedis = new Jedis(host, port);
	    	//jedis.auth("password");
	    	System.out.println("Getting data from Redis Cache");
	    	String value = jedis.get((String)key);
	    	DefaultMuleMessage msg = new DefaultMuleMessage(value, muleEvent.getMuleContext() );
	   // 	System.out.println("msg: " + msg);
	    	
	    	muleEvent.setMessage(msg);
	    	return  (T) muleEvent;
		}
		return null;
		
	}

	@Override
	public synchronized T remove(Serializable key) throws ObjectStoreException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public synchronized boolean isPersistent() {
		// TODO Auto-generated method stub
		System.out.println("inside ispersistent method");
		return true;
	}

	@Override
	public synchronized void clear() throws ObjectStoreException {
		// TODO Auto-generated method stub
		
	}

		
	}
