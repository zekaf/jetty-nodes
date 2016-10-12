
import java.beans.XMLDecoder;
import java.beans.XMLEncoder;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.HashMap;


public class XMLCode {
	
	public static HashMap<String,Integer> fileToMap(String fileName) {
		HashMap<String,Integer > t = null;
		try{
			XMLDecoder decoder = new XMLDecoder(new BufferedInputStream(
					new FileInputStream(fileName)));
			t = (HashMap<String, Integer>)decoder.readObject();
			decoder.close();

		}
		catch(Exception e){
			System.out.println(e);
		}
		return t;
	} 

	public static boolean mapToFile(String fileName, HashMap<String, Integer> t){
		try{
			XMLEncoder encoder = new XMLEncoder( new BufferedOutputStream(
					new FileOutputStream(fileName)));
			encoder.writeObject(t);
			encoder.close();
		}
		catch(Exception e){
			return false;
		}
		return true;
	}

}
