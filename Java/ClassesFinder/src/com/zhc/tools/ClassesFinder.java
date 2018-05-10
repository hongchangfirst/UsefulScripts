package com.zhc.tools;

import java.util.Set;

import org.reflections.Reflections;

public class ClassesFinder {
    public static void main(String[] args) throws Exception {
        Reflections reflections = new Reflections(".*");
        Class clazz = Class.forName("com.amazon.identity.cvf.verification.VerificationService");

        Set<Class> subClasses = reflections.getSubTypesOf(clazz);
        for (Class c : subClasses) {
            System.out.println(c.getCanonicalName());
        }
    }
}