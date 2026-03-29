from django.shortcuts import render
from django.http import HttpResponse

# Create your views here.

my_information = {
    'İsim' : 'Ali'
}

def say_hello(request):
    return render(request, 'hello.html' , {'nams' : 'Ali'})
