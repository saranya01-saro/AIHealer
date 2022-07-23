import numpy as np
from flask import Flask, request, jsonify, render_template
import pandas as pd
import json
from json import JSONEncoder
import pickle
app = Flask(__name__)

@app.route('/emotion',methods=['GET'])
def hello_world():

    d= str(request.args['Query'])
    #important libraries
    import pandas as pd
    import numpy as np
    import nltk
    import re
    #importing stopwords is optional, in this case it decreased accuracy
    #from nltk.corpus import stopwords
    import itertools
    import time

    nltk.download('punkt')
    nltk.download('wordnet')

    data = pd.read_csv('tweet_emotions.csv')
    #data = data.iloc[:100,:]


    #stopset = set(stopwords.words('english'))

    from nltk.stem.wordnet import WordNetLemmatizer 
    lem = WordNetLemmatizer()

    #comprehensive cleaning
    def cleaning(text):
        txt = str(text)
        txt = re.sub(r"http\S+", "", txt)
        if len(txt) == 0:
            return 'no text'
        else:
            txt = txt.split()
            index = 0
            for j in range(len(txt)):
                if txt[j][0] == '@':
                    index = j
            txt = np.delete(txt, index)
            if len(txt) == 0:
                return 'no text'
            else:
                words = txt[0]
                for k in range(len(txt)-1):
                    words+= " " + txt[k+1]
                txt = words
                txt = re.sub(r'[^\w]', ' ', txt)
                if len(txt) == 0:
                    return 'no text'
                else:
                    txt = ''.join(''.join(s)[:2] for _, s in itertools.groupby(txt))
                    txt = txt.replace("'", "")
                    txt = nltk.tokenize.word_tokenize(txt)
                    #data.content[i] = [w for w in data.content[i] if not w in stopset]
                    for j in range(len(txt)):
                        txt[j] = lem.lemmatize(txt[j], "v")
                    if len(txt) == 0:
                        return 'no text'
                    else:
                        return txt

    from sklearn.feature_extraction.text import TfidfTransformer
    from sklearn.feature_extraction.text import CountVectorizer

    model = pickle.load(open('model.pkl','rb'))
    transformer = TfidfTransformer()
    loaded_vec = CountVectorizer(decode_error="replace",vocabulary=pickle.load(open("feature.pkl", "rb")))
    tfidf = transformer.fit_transform(loaded_vec.fit_transform([d]))
    a=[]
    a=(model.predict(tfidf))
    string = " ". join(a)   
    return jsonify(string) 


@app.route('/quotes',methods=['GET'])
def hello_world1():
    d= str(request.args['Query'])
    import os
    import numpy as np
    import pandas as pd

    movies_df = pd.read_csv('quotes_filtered_2.csv')
    movies_df['text'] = movies_df['text'].astype(str)

    from sklearn.feature_extraction.text import  TfidfVectorizer
    vectorizer = TfidfVectorizer( stop_words='english')
    def find_similar(title):
        max =0
        ans =""
        for i in range(2500): 
            tfidf = vectorizer.fit_transform([title,movies_df['text'][i]])
            if(((tfidf * tfidf.T).A)[0,1]>max):
                max=((tfidf * tfidf.T).A)[0,1]
                ans = movies_df['text'][i]
        return ans 

    ans = find_similar(d)  
    return jsonify(ans) 

@app.route('/song',methods=['GET'])
def hello_world2():
    d= str(request.args['Query'])
    import pandas as pd
    import random
    df = pd.read_csv('songs.csv')
    gk = df.groupby('emotion')
    def findsong(emotion):
        lst = gk.get_group(emotion)
        lst1 =lst['songs'].to_list()
        n = random.randint(0,len(lst1)-1)
        return lst1[n]

    return jsonify(findsong(d))
@app.route('/food',methods=['GET'])
def hello_world3():
    d= str(request.args['Query'])
    import pandas as pd
    import random
    df = pd.read_csv('food.csv')
    gk = df.groupby('emotion')
    def findfood(emotion):
        lst = gk.get_group(emotion)
        lst1 =lst['food'].to_list()
        n = random.randint(0,len(lst1)-1)
        return lst1[n]

    return jsonify(findfood(d))



if __name__ == "__main__":
 app.run(debug=True)