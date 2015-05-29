#include<iostream>
#include<cstdio>

using namespace std;

const int size = 100;

class Symbol_Info
{
public:
	string key;
	string type;
	double value;
	string code;
    string labelTrue;
    string labelFalse;
};

class Node
{
public:
	Symbol_Info symbol;
	Node *prev;
	Node *next;
	Node()
	{
		prev= NULL;
		next= NULL;
	}
	Node (string k, string v)
	{
		symbol.key=k;
		symbol.type=v;
		if (v == "NUMBER")
		{
			sscanf(k.c_str(),"%lf",&symbol.value);
		}
		else symbol.value =0;
		symbol.code="";
		prev=next=NULL;
	//	cout<< symbol.value<<end;
	}
	Node (Symbol_Info s)
	{
		symbol.key=s.key;
		symbol.type=s.type;
		if (s.type == "NUMBER")
		{
			sscanf(s.key.c_str(),"%lf",&symbol.value);
		}
		else symbol.value =0;
		symbol.code="";
		prev=next=NULL;
		
	}
};



class LinkedList
{
public:
	Node * head;
	Node* tail;
public:
	LinkedList()
	{
		head=tail=NULL;
	}
	
	void addNode(Symbol_Info s)
	{
		Node *newNode=new Node(s);
	//	cout<<newNode->symbol.value<<endl;
		if(head==NULL)
		{
			head= newNode;
			tail=newNode;
		}
		else
		{
			newNode->next=head;
			newNode->prev=NULL;
			head->prev=newNode;
			head=newNode;
		}
		
	}
	
	Node * FindNode(string k)
	{
		int flag=0;
		Node * newNode= new Node();
		newNode=head;
		if (head==NULL) return NULL;
		
		while(1)
		{
			if(newNode->symbol.key==k) 
			{
				//cout<<"paisi"<<endl;		
				flag=1;
				break;
			}
			if(newNode->next==NULL) break;
			newNode=newNode->next;
		}	
		if(flag==1) return newNode;
		return NULL;
	}
	
	void show(FILE *fp, int line )
	{
		Node *temp=new Node();
		temp=head;
		while(temp)
		{
			fprintf(fp,"[%d]-> %s , %s, %lf \n",line,temp->symbol.type.c_str(),temp->symbol.key.c_str(),temp->symbol.value);
			
			temp=temp->next;
		}
		
	}
	
	void Delete(string k)
	{
		Node* temp= new Node();
		temp= FindNode(k);
		if(temp && temp==head && temp==tail)
		{
			head=tail=NULL;
			delete temp;
		}
		else if(temp)
		{
				if(temp->prev) temp->prev->next= temp->next;
				else head=temp->next;
				if(temp->next) temp->next->prev=temp->prev;
				else tail=temp->prev;
				delete temp;
		}
		else
		{
			cout<<"No Node Found............."<<endl;
		}
	}
	
};

class SymbolTable
{
public:
	LinkedList *list;
public:
	SymbolTable()
	{
		list= new LinkedList[size+1];
		for(int i=0;i<=size;i++)
		{
			list[i].head=list[i].tail=NULL;
		}
	}
	
	int hash(string k)
	{
		int res;
		int sum=0;
		int len= k.length();
		for(int i=0;i<len;i++)
		{
				sum=sum+(k[i]*(i+1));
		}
		
		res=sum%size;
		return res;
	}
	
	bool lookup(string s)
	{
		int index= hash (s);
		Node *temp= new Node();
		temp=list[index].FindNode(s);
		if (temp) return true;
		return false;
	}
	
	Node * uplook(string s)
	{
		int index= hash (s);
		Node *temp= new Node();
		temp=list[index].FindNode(s);
		if (temp) return temp;
		return NULL;
	}
	
	void insert(Symbol_Info s)
	{
		bool present= lookup(s.key);
		
		if(!present)
		{
			int index=hash(s.key);
			list[index].addNode(s);
		}
	}
	
	void delete_(string k)
	{
		bool present=lookup(k);
		if(present)
		{
			int index=hash(k);
			list[index].Delete(k);
		}
	}
	
	void dump(FILE *fp )
	{
		int i;
		for(i=0;i<size;i++)
		{
			list[i].show(fp,i);
		}
	}
	
};

