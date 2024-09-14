importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing in the messagingSenderId.
firebase.initializeApp({
      apiKey: 'AIzaSyAfouysDbxNUu5G0ueIAq-M82EE8RSdY1I',
      appId: '1:935139855472:web:a99c17552f6f4f2914f8b5',
      messagingSenderId: '935139855472',
      projectId: 'smart-cradle-system-3e551',
      authDomain: 'smart-cradle-system-3e551.firebaseapp.com',
      storageBucket: 'smart-cradle-system-3e551.appspot.com',
      measurementId: 'G-WMXNYGW1J7',
});

// Retrieve an instance of Firebase Messaging so that it can handle background messages.
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  // Customize notification here
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/favicon.png'
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});
