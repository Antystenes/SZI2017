#!/usr/bin/python2

from __future__ import print_function
import numpy as np
np.random.seed(666)  # for reproducibility

import sys
from keras.utils import np_utils
from keras       import optimizers
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, Embedding, Input, merge
from keras.layers import LSTM
from keras.models import Model

import cPickle as pickle
import ast

input_size = 454

batch_size = 128


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
    model.add(Dense(256, input_dim=input_size, activation='tanh'))
    model.add(Dense(64, activation='tanh'))
    model.add(Dense(16, activation='tanh'))
    model.add(Dense(4, activation='sigmoid'))

    #sgd = optimizers.SGD(lr=0.1, momentum=0.1, decay=0.01)

    model.compile(loss='mse',
                  optimizer='adagrad',
                  metrics=['mse'])
    model.fit(X_train, Y_train, batch_size=batch_size, epochs=2)
    json_string = model.to_json()
    open('model_architecture.json', 'w').write(json_string)
    model.save_weights('model_weights.h5', overwrite=True)
