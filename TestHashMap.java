/**
 * @ # TestHashMap.java
 * class to test HashMaps
 * using XML serialization
 * version: 1 Out. 2015
 * author: Jose G. Faisca  
 */

import java.beans.XMLDecoder;
import java.beans.XMLEncoder;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Scanner;

public class TestHashMap {

	// verify file 	
	public static boolean fileVerify(String file){
		File inFile = new File(file);
		if (!inFile.isFile()) {
			return false;
		}
		else
			return true;
	}
	
	//order table
	public static List<String> descendingSortMapByValue(final Map<String, Integer> m) {
		List<String> k = new ArrayList<String>(m.keySet());
		Collections.sort(k, new Comparator<Object>(){ 
			public int compare(Object a, Object b) {
				if(m.get(a) < m.get(b)) {
					return -1;
				}	
				if(m.get(a) > m.get(b)) {
					return 1;
				} 
				return 0;
			}        	
		});
		return k;
	}

	public static void main(String[] args){

		HashMap<String,Integer > table = new HashMap<String,Integer>();

		String inputkey,key,value;
		int inputvalue;
		int option = 0;
		Iterator<String> iterator;
		Scanner scan = new Scanner(System.in);
		String file = "object.xml";//default file

		if (args.length == 1)
			file = args[0];		

		if (fileVerify(file)){//verify file
			table.clear();
			table = XMLCode.fileToMap(file);
		}	
		else{
			System.err.println ("error reading file "+file);
			System.exit(-1);
		}

		while (true) {
			System.out.println("\nHash Map Menu:");
			System.out.println("   1.  test put(key,value)");
			System.out.println("   2.  test get(key)");
			System.out.println("   3.  test containsKey(key)");
			System.out.println("   4.  test remove(key)");
			System.out.println("   5.  test table.containsValue(value)"); 
			System.out.println("   6.  test table.size()"); 
			System.out.println("   7.  show table ");
			System.out.println("   8.  test table.clear()");
			System.out.println("   9.  order by key");
			System.out.println("   10. order by value");
			System.out.println("   11. create table from XML");
			System.out.println("   12. copy table to XML");
			System.out.println("   13. EXIT");
			System.out.print("Write a command:  ");
			option = scan.nextInt();
			switch (option) {
			case 1:
				System.out.print("\n   Key = ");
				inputkey = scan.next();
				System.out.print("   Value = ");
				inputvalue = scan.nextInt();
				table.put(inputkey,inputvalue);
				break;         
			case 2:
				System.out.print("\n   Key = ");
				inputkey = scan.next();
				System.out.println("   Value = " + table.get(inputkey));
				break;         
			case 3:
				System.out.print("\n   Key = ");
				inputkey = scan.next();
				System.out.println("   containsKey(" + inputkey + ") = " 
						+ table.containsKey(inputkey));
				break;         
			case 4:
				System.out.print("\n   Key = ");
				inputkey = scan.next();
				Integer remove = table.remove(inputkey);
				String msg = "false";
				if(remove != null)
					msg="true";				
				System.out.println("   remove(" + inputkey + ") = "+ msg);					
				break; 
			case 5:
				System.out.print("\n   Value = ");
				inputvalue = scan.nextInt();
				System.out.println("   containsValue(" + inputvalue + ") = " 
						+ table.containsValue(inputvalue));				
				break;
			case 6:
				System.out.println("\n   size = "+ table.size());
				break;
			case 7:
				System.out.println ("");
				iterator = table.keySet().iterator();  
				while (iterator.hasNext()) {  
					key = iterator.next().toString();  
					value = table.get(key).toString();  
					System.out.println(key+", "+value);
				}
				break;
			case 8:
				table.clear();
				System.out.println("\n   size = "+ table.size()); 
				break;
			case 9:
				System.out.println ("");
				List<String> v = new ArrayList<String>(table.keySet());
				Collections.sort(v);
				for (int i = 0; i < v.size(); i++) {
					key = v.get(i);
					value = table.get(key).toString();
					System.out.println(key +", "+ value);
				}
				break;	
			case 10:
				System.out.println ("");
				iterator = descendingSortMapByValue(table).iterator();
				while (iterator.hasNext()) {  
					key = iterator.next().toString();  
					value = table.get(key).toString();  
					System.out.println(key +", "+ value);
				}
				break;				
			case 11:	
				table.clear();
				table = XMLCode.fileToMap(file);
				System.out.println("table created from "+file);			
				break;
			case 12:
				if(XMLCode.mapToFile(file,table))
					System.out.println("table copied to "+file);
				else
					System.out.println("ERROR: copy table to "+file );	
				break;
			case 13:
				return;  //return to main()         
			default:
				System.out.println("invalid command");
				break;
			}
		}
	}

} // end class TestHashMap
