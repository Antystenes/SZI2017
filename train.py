#!/usr/bin/python2

from __future__ import print_function
import numpy as np
np.random.seed(1337)  # for reproducibility

import sys
from keras.utils import np_utils
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, Embedding, Input, merge
from keras.layers import LSTM
from keras.models import Model

import cPickle as pickle
import ast

input_size = 454

batch_size = 1024


def get_corpus():
    X = []
    Y = []
    for idx, line in enumerate(sys.stdin.readlines()):
        if idx % 2 == 1:
            Y.append(ast.literal_eval(line))
        else:
            X.append(ast.literal_eval(line))
    return X,Y

if __name__ == '__main__':

    X,Y = get_corpus()
    X_train = np.array(X)
    Y_train = np.array(Y)

    model = Sequential()
    model.add(Dense(128, input_dim=input_size, activation='elu'))
    model.add(Dense(64, activation='tanh'))
    model.add(Dense(4, activation='sigmoid'))

    model.compile(loss='mse',
                  optimizer='rmsprop',
                  metrics=['accuracy'])
    model.fit(X_train, Y_train, batch_size=batch_size, epochs=5)
    json_string = model.to_json()
    open('model_architecture.json', 'w').write(json_string)
    model.save_weights('model_weights.h5', overwrite=True)