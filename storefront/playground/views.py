from django.shortcuts import render
from django.http import HttpResponse
from store.models import Product
from store.models import OrderItem
from store.models import Order
from store.models import Customer
from django.db.models import Func,Value,F

# Create your views here.

my_information = {
    'İsim' : 'Ali'
}

def say_hello(request):
    query_set = Customer.objects.annotate(full_name=Func(F('first_name'),Value(' ') ,F('last_name'), function='CONCAT'))
        
    return render(request, 'hello.html' , {'name' : 'Ali', 'products':list(query_set)})


