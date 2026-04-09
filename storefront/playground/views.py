from django.shortcuts import render
from django.http import HttpResponse
from store.models import Product
from store.models import OrderItem
from store.models import Order

# Create your views here.

my_information = {
    'İsim' : 'Ali'
}

def say_hello(request):
    query_set = Order.objects.select_related('customer').prefetch_related('orderitem_set__product').order_by('-placed_at')[:5]
        
    return render(request, 'hello.html' , {'name' : 'Ali', 'products':list(query_set)})
