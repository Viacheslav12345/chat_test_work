# Застосунок "Чат" для обміну повідомленнями з використанням Firebase Realtime Database.

Функціонал:
1. При першому вході до застосунку автоматично присвоюється унікальний ID поточного користувача - наступний за вже наявними ID інших користувачів в базі даних.   
2. Після запуску відкриваєтсья сторінка входу, на якій відображається вже присвоєний ID поточного користувача та текстове поле для введення ID чату для спілкування з іншими користувачами.
3. ID поточного користувача, та його дані зберігаються після першого входу до локального сховища SharedPreferences і у віддаленому сховищі Firebase Realtime Database  та доступні після наступних входів. 
4. Зміна аватарки користувача, імені та професії відбувається по кліку.
5. При введенні ID чату в текстове поле, відкривається сторінка чату з підвантаженою історією спілкування. 
6. Зверху сторінки чату відображається перелік аватарок користувачів поточного чату та час входу останнього користувача.
7. Після написання та відправки повідомлення, воно відображаєтсья на всіх пристроях з відображенням часу надсилання.

 <p float="left">
    <img src="https://user-images.githubusercontent.com/101039162/232745768-2346e390-f7ce-49ec-ae98-64228a63ec3d.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/232745766-cc80205d-795f-4c4f-9277-ca719f61bf4c.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/232745764-93921e3b-86e8-47be-a6e2-ea949be4f9b3.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/229155608-f049eeaa-ab23-466e-8146-4b08678089c7.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/229155615-855b64c8-dd3a-451c-a560-2c2ffaab61cd.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/232745758-d5fc612c-2c16-44b1-8b0e-c22e3c0d8acf.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/232745770-2343a276-660b-4867-80c1-1b8a5e29051a.jpg" alt="Preview" height="500px"/>
    <img src="https://user-images.githubusercontent.com/101039162/232747256-60f63366-d5f5-4079-aeea-3d138bce51ab.jpg" alt="Preview" height="500px"/>
    
</p>
