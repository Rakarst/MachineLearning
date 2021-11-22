function reduced_data = create_train_autoencoder(X, n)
    % n = 10, 15, 3
    autoencoder = trainAutoencoder(X',n);
    reduced_data = autoencoder.encode(X');